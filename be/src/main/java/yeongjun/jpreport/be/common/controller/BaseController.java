package yeongjun.jpreport.be.common.controller;

import yeongjun.jpreport.be.common.response.ApiResponse;
import yeongjun.jpreport.be.common.response.PageResponse;
import org.springframework.http.ResponseEntity;
import java.util.List;

/**
 * 基底コントローラークラス
 * Base Controller Class
 */
public abstract class BaseController {
    
    /**
     * 成功レスポンスを返す
     * Return success response
     */
    protected <T> ResponseEntity<ApiResponse<T>> success(T data) {
        return ResponseEntity.ok(ApiResponse.success(data));
    }
    
    /**
     * 成功レスポンス（メッセージ付き）を返す
     * Return success response with a message
     */
    protected <T> ResponseEntity<ApiResponse<T>> success(String message, T data) {
        return ResponseEntity.ok(ApiResponse.success(message, data));
    }
    
    /**
     * ページングレスポンスを返す
     * Return paginated response
     */
    protected <T> ResponseEntity<ApiResponse<PageResponse<T>>> successPage(
            List<T> content, int page, int size, long totalElements) {
        PageResponse<T> pageResponse = PageResponse.of(content, page, size, totalElements);
        return ResponseEntity.ok(ApiResponse.success(pageResponse));
    }
    
    /**
     * ページングレスポンス（メッセージ付き）を返す
     * Return paginated response with message
     */
    protected <T> ResponseEntity<ApiResponse<PageResponse<T>>> successPage(
            String message, List<T> content, int page, int size, long totalElements) {
        PageResponse<T> pageResponse = PageResponse.of(content, page, size, totalElements);
        return ResponseEntity.ok(ApiResponse.success(message, pageResponse));
    }
    
    /**
     * エラーレスポンスを返す
     * Return error response
     */
    protected <T> ResponseEntity<ApiResponse<T>> error(String message) {
        return ResponseEntity.badRequest().body(ApiResponse.error(message));
    }
}
