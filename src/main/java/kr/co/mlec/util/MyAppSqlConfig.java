package kr.co.mlec.util;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MyAppSqlConfig {
	private static final SqlSession sqlMapper;
	static {
		try {
			String resource = "config/mybatis/sqlMapConfig.xml";
			Reader reader = Resources.getResourceAsReader(resource);
			SqlSessionFactory sqlFactory = new SqlSessionFactoryBuilder().build(reader);
			sqlMapper = sqlFactory.openSession();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Error initializing MyAppSqlConfig class. Cause: " + e);
		}
	}

	public static SqlSession getSqlSessionInstance() {
		return sqlMapper;
	}
}