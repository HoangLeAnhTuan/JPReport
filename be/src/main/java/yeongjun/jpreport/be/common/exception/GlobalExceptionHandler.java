package yeongjun.jpreport.be.common.exception;

import yeongjun.jpreport.be.common.response.ApiResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * グローバル例外ハンドラー
 * Global Exception Handler for centralized error handling
 */
@RestControllerAdvice
public class GlobalExceptionHandler {
    
    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
    
    /**
     * ビジネス例外処理
     * Handle Business Exceptions
     */
    @ExceptionHandler(BusinessException.class)
    public ResponseEntity<ApiResponse<Object>> handleBusinessException(BusinessException ex) {
        logger.warn("Business Exception: {} - {}", ex.getErrorCode(), ex.getMessage());
        return ResponseEntity
            .badRequest()
            .body(ApiResponse.error(ex.getMessage()));
    }
    
    /**
     * システム例外処理
     * Handle System Exceptions
     */
    @ExceptionHandler(SystemException.class)
    public ResponseEntity<ApiResponse<Object>> handleSystemException(SystemException ex) {
        logger.error("System Exception: {} - {}", ex.getErrorCode(), ex.getMessage(), ex);
        return ResponseEntity
            .status(HttpStatus.INTERNAL_SERVER_ERROR)
            .body(ApiResponse.error("システムエラーが発生しました"));
    }
    
    /**
     * バリデーション例外処理 (RequestBody)
     * Handle Validation Exceptions for RequestBody
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ApiResponse<Object>> handleValidationException(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach(error -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        
        logger.warn("Validation Exception: {}", errors);
        return ResponseEntity
            .badRequest()
            .body(ApiResponse.error("入力値に誤りがあります: " + errors.toString()));
    }
    
    /**
     * バリデーション例外処理 (ModelAttribute)
     * Handle Validation Exceptions for ModelAttribute
     */
    @ExceptionHandler(BindException.class)
    public ResponseEntity<ApiResponse<Object>> handleBindException(BindException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach(error -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        
        logger.warn("Bind Exception: {}", errors);
        return ResponseEntity
            .badRequest()
            .body(ApiResponse.error("入力値に誤りがあります: " + errors.toString()));
    }
    
    /**
     * 制約違反例外処理
     * Handle Constraint Violation Exceptions
     */
    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<ApiResponse<Object>> handleConstraintViolationException(ConstraintViolationException ex) {
        String errors = ex.getConstraintViolations()
            .stream()
            .map(ConstraintViolation::getMessage)
            .collect(Collectors.joining(", "));
        
        logger.warn("Constraint Violation Exception: {}", errors);
        return ResponseEntity
            .badRequest()
            .body(ApiResponse.error("制約違反: " + errors));
    }
    
    /**
     * 引数型不一致例外処理
     * Handle Method Argument Type Mismatch Exceptions
     */
    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    public ResponseEntity<ApiResponse<Object>> handleTypeMismatchException(MethodArgumentTypeMismatchException ex) {
        String message = String.format("パラメータ '%s' の値 '%s' は無効です", 
            ex.getName(), ex.getValue());
        
        logger.warn("Type Mismatch Exception: {}", message);
        return ResponseEntity
            .badRequest()
            .body(ApiResponse.error(message));
    }
    
    /**
     * その他の例外処理
     * Handle All Other Exceptions
     */
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiResponse<Object>> handleGenericException(Exception ex) {
        logger.error("Unexpected Exception: {}", ex.getMessage(), ex);
        return ResponseEntity
            .status(HttpStatus.INTERNAL_SERVER_ERROR)
            .body(ApiResponse.error("予期しないエラーが発生しました"));
    }
}
