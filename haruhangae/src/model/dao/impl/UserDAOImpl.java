package model.dao.impl;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import mapper.UserMapper;
import model.UserDTO;
import model.dao.UserDAO;

/*사용자 관리를 위해 데이터베이스 작업을 전담하는 DAO 클래스 USER 테이블에 사용자 정보를 추가, 수정, 삭제, 검색 수행 */
public class UserDAOImpl implements UserDAO {
	private SqlSessionFactory sqlSessionFactory = createSqlSessionFactory();
	private JDBCUtil jdbcUtil = null;

	public UserDAOImpl() {
		jdbcUtil = new JDBCUtil();
		createSqlSessionFactory();
	}

	private SqlSessionFactory createSqlSessionFactory() {
		String resource = "mybatis-config.xml";
		InputStream inputStream;
		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			throw new IllegalArgumentException(e);
		}
		return new SqlSessionFactoryBuilder().build(inputStream);
	}

	/* 회원가입 */
	public int createUser(UserDTO user) {
		SqlSession sqlSession = sqlSessionFactory.openSession();

		try {
			int result = sqlSession.getMapper(UserMapper.class).createUser(user);
			if (result > 0) {
				sqlSession.commit();
			}
			return result;
		} finally {
			sqlSession.close();
		}
	}

	/* 회원 정보 수정 */
	public int updateUser(UserDTO user) {
		SqlSession sqlSession = sqlSessionFactory.openSession();

		try {
			int result = sqlSession.getMapper(UserMapper.class).updateUser(user);
			if (result > 0) {
				sqlSession.commit();
			}
			return result;
		} finally {
			sqlSession.close();
		}
	}

	/* 회원 탈퇴 */
	public int removeUser(String userID) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int result = sqlSession.getMapper(UserMapper.class).removeUser(userID);
			if (result > 0) {
				sqlSession.commit();
			}
			return result;
		} finally {
			sqlSession.close();
		}
	}

	/* 주어진 사용자 ID에 해당하는 사용자 정보를 데이터베이스에서 찾아 User 도메인 클래스에 저장하여 반환. */

	public UserDTO findUser(String userID) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			UserDTO user = sqlSession.getMapper(UserMapper.class).findUser(userID);

			if (user == null) {
				return null;
			}

			String password = user.getPassword();
			String alias = user.getAlias();
			String email = user.getEmail();
			String phone = user.getPhone();
			return new UserDTO(userID, password, alias, email, phone, addTotalMission(userID), addTotalReward(userID),
					findCatName(userID));
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			sqlSession.close();
		}
		return null;
	}

	public int addTotalMission(String userID) {
		SqlSession sqlSession = sqlSessionFactory.openSession();

		try {
			return sqlSession.getMapper(UserMapper.class).addTotalMission(userID);
		} finally {
			sqlSession.close();
		}
	}

	public int addTotalReward(String userID) {
		SqlSession sqlSession = sqlSessionFactory.openSession();

		try {
			return sqlSession.getMapper(UserMapper.class).addTotalReward(userID);
		} finally {
			sqlSession.close();
		}
	}

	/* 현재 진행중인 카테고리 이름을 반환 */
	public String findCatName(String userID) {
		SqlSession sqlSession = sqlSessionFactory.openSession();

		try {
			sqlSession.getMapper(UserMapper.class).findCatName(userID);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();
		}
		return null;
	}

	/* 카테고리 성공 여부 (14일 중 12일 이상) */
	public boolean isSuccessed(String userID, String catID) {
		SqlSession sqlSession = sqlSessionFactory.openSession();

		try {
			int missionClearCnt = sqlSession.getMapper(UserMapper.class).isSuccessed(userID, catID);
			return (missionClearCnt >= 12 ? true : false);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();
		}
		return false;
	}

	/* 주어진 사용자 ID에 해당하는 사용자가 존재하는지 검사 */
	public boolean existingUser(String userID) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int count = sqlSession.getMapper(UserMapper.class).existingUser(userID);
			System.out.println(count);
			return (count == 1 ? true : false);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();
		}
		return false;
	}
}