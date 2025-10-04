package yeongjun.jpreport.be.common.response;

import yeongjun.jpreport.be.common.constants.ApiConstant;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

/**
 * 統一API レスポンス形式
 * Standard API Response Format
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ApiResponse<T> {
    
    private int code;         
    private String message;
    private T data;
    private String timestamp;
    
    /**
     * 成功レスポンス（データのみ）
     * Success response with data only
     */
    public static <T> ApiResponse<T> success(T data) {
        return new ApiResponse<>(ApiConstant.SUCCESS_CODE, "Success", data, LocalDateTime.now().toString());
    }
    
    /**
     * 成功レスポンス（メッセージ付き）
     * Success response with custom message
     */
    public static <T> ApiResponse<T> success(String message, T data) {
        return new ApiResponse<>(ApiConstant.SUCCESS_CODE, message, data, LocalDateTime.now().toString());
    }
    
    /**
     * エラーレスポンス
     * Error response
     */
    public static <T> ApiResponse<T> error(String message) {
        return new ApiResponse<>(ApiConstant.ERROR_CODE, message, null, LocalDateTime.now().toString());
    }
}
