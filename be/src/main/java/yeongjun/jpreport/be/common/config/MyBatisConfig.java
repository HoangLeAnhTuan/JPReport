package yeongjun.jpreport.be.common.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;

/**
 * MyBatis設定クラス
 * MyBatis Configuration
 */
@Configuration
@MapperScan(basePackages = "yeongjun.jpreport.be.*.dao")
public class MyBatisConfig {
    
    /**
     * SqlSessionFactory設定
     * Configure SqlSessionFactory
     */
    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(dataSource);
        
        // Mapper XML files location
        sessionFactory.setMapperLocations(
            new PathMatchingResourcePatternResolver().getResources("classpath:mapper/**/*.xml")
        );
        
        // Type aliases package
        sessionFactory.setTypeAliasesPackage("yeongjun.jpreport.be.*.entity");
        
        return sessionFactory.getObject();
    }
}
