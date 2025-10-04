package yeongjun.jpreport.be.common.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import lombok.Data;

/**
 * アプリケーション設定クラス
 * Application Configuration Properties
 */
@Configuration
@ConfigurationProperties(prefix = "app")
@Data
public class AppConfig {
    
    private Jwt jwt = new Jwt();
    
    @Data
    public static class Jwt {
        private String secret;
        private long expiration;
        private long refreshExpiration;
    }
}
