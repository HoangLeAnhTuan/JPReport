package yeongjun.jpreport.be.common.utils;

import yeongjun.jpreport.be.common.exception.BusinessException;
import java.util.Collection;
import java.util.regex.Pattern;

/**
 * バリデーションユーティリティクラス
 * Validation Utility Class
 */
public class ValidationUtils {
    
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );
    
    private static final Pattern PHONE_PATTERN = Pattern.compile(
        "^[0-9]{2,4}-[0-9]{2,4}-[0-9]{3,4}$"
    );
    
    /**
     * null チェック
     * Check if object is null
     */
    public static void requireNonNull(Object obj, String message) {
        if (obj == null) {
            throw new BusinessException("VALIDATION_ERROR", message);
        }
    }
    
    /**
     * 空文字チェック
     * Check if string is empty or null
     */
    public static void requireNonEmpty(String str, String message) {
        if (str == null || str.trim().isEmpty()) {
            throw new BusinessException("VALIDATION_ERROR", message);
        }
    }
    
    /**
     * コレクション空チェック
     * Check if collection is empty or null
     */
    public static void requireNonEmpty(Collection<?> collection, String message) {
        if (collection == null || collection.isEmpty()) {
            throw new BusinessException("VALIDATION_ERROR", message);
        }
    }
    
    /**
     * 文字列長チェック
     * Check string length
     */
    public static void requireLength(String str, int minLength, int maxLength, String message) {
        if (str == null) {
            throw new BusinessException("VALIDATION_ERROR", message);
        }
        int length = str.length();
        if (length < minLength || length > maxLength) {
            throw new BusinessException("VALIDATION_ERROR", message);
        }
    }
    
    /**
     * 数値範囲チェック
     * Check number range
     */
    public static void requireRange(Number number, Number min, Number max, String message) {
        if (number == null) {
            throw new BusinessException("VALIDATION_ERROR", message);
        }
        double value = number.doubleValue();
        double minValue = min.doubleValue();
        double maxValue = max.doubleValue();
        
        if (value < minValue || value > maxValue) {
            throw new BusinessException("VALIDATION_ERROR", message);
        }
    }
    
    /**
     * メールアドレス形式チェック
     * Validate email format
     */
    public static void requireValidEmail(String email, String message) {
        if (email == null || !EMAIL_PATTERN.matcher(email).matches()) {
            throw new BusinessException("VALIDATION_ERROR", message);
        }
    }
    
    /**
     * 電話番号形式チェック
     * Validate phone number format
     */
    public static void requireValidPhone(String phone, String message) {
        if (phone == null || !PHONE_PATTERN.matcher(phone).matches()) {
            throw new BusinessException("VALIDATION_ERROR", message);
        }
    }
    
    /**
     * 正規表現チェック
     * Validate with regex pattern
     */
    public static void requirePattern(String str, Pattern pattern, String message) {
        if (str == null || !pattern.matcher(str).matches()) {
            throw new BusinessException("VALIDATION_ERROR", message);
        }
    }
    
    /**
     * 条件チェック
     * Check condition
     */
    public static void requireTrue(boolean condition, String message) {
        if (!condition) {
            throw new BusinessException("VALIDATION_ERROR", message);
        }
    }
    
    /**
     * 安全な文字列チェック（null の場合は空文字を返す）
     * Safe string check (return empty string if null)
     */
    public static String safeString(String str) {
        return str != null ? str : "";
    }
    
    /**
     * 文字列が有効かチェック
     * Check if string is valid (not null and not empty)
     */
    public static boolean isValidString(String str) {
        return str != null && !str.trim().isEmpty();
    }
    
    /**
     * メールアドレスが有効かチェック
     * Check if email is valid
     */
    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }
}
