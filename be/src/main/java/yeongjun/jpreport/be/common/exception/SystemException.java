package yeongjun.jpreport.be.common.exception;

import lombok.Getter;

/**
 * システム例外クラス
 * System Exception for technical/infrastructure errors
 */
@Getter
public class SystemException extends RuntimeException {
    
    private final String errorCode;
    
    public SystemException(String message) {
        super(message);
        this.errorCode = "SYSTEM_ERROR";
    }
    
    public SystemException(String errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
    }
    
    public SystemException(String message, Throwable cause) {
        super(message, cause);
        this.errorCode = "SYSTEM_ERROR";
    }
    
    public SystemException(String errorCode, String message, Throwable cause) {
        super(message, cause);
        this.errorCode = errorCode;
    }

}
