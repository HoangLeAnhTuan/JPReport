package yeongjun.jpreport.be.common.utils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

/**
 * 日付ユーティリティクラス
 * Date Utility Class
 */
public class DateUtils {
    
    public static final String DATE_PATTERN = "yyyy-MM-dd";
    public static final String DATETIME_PATTERN = "yyyy-MM-dd HH:mm:ss";
    public static final String JAPANESE_DATE_PATTERN = "yyyy年MM月dd日";
    
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern(DATE_PATTERN);
    private static final DateTimeFormatter DATETIME_FORMATTER = DateTimeFormatter.ofPattern(DATETIME_PATTERN);
    private static final DateTimeFormatter JAPANESE_DATE_FORMATTER = DateTimeFormatter.ofPattern(JAPANESE_DATE_PATTERN);
    
    /**
     * 現在日時を取得
     * Get current date time
     */
    public static LocalDateTime now() {
        return LocalDateTime.now();
    }
    
    /**
     * 現在日付を取得
     * Get current date
     */
    public static LocalDate today() {
        return LocalDate.now();
    }
    
    /**
     * 日付を文字列に変換
     * Convert date to string
     */
    public static String formatDate(LocalDate date) {
        return date != null ? date.format(DATE_FORMATTER) : null;
    }
    
    /**
     * 日時を文字列に変換
     * Convert datetime to string
     */
    public static String formatDateTime(LocalDateTime dateTime) {
        return dateTime != null ? dateTime.format(DATETIME_FORMATTER) : null;
    }
    
    /**
     * 日付を日本語形式で変換
     * Convert date to Japanese format
     */
    public static String formatDateJapanese(LocalDate date) {
        return date != null ? date.format(JAPANESE_DATE_FORMATTER) : null;
    }
    
    /**
     * 文字列を日付に変換
     * Parse string to date
     */
    public static LocalDate parseDate(String dateString) {
        return dateString != null ? LocalDate.parse(dateString, DATE_FORMATTER) : null;
    }
    
    /**
     * 文字列を日時に変換
     * Parse string to datetime
     */
    public static LocalDateTime parseDateTime(String dateTimeString) {
        return dateTimeString != null ? LocalDateTime.parse(dateTimeString, DATETIME_FORMATTER) : null;
    }
    
    /**
     * 二つの日付の差を日数で取得
     * Get days between two dates
     */
    public static long daysBetween(LocalDate startDate, LocalDate endDate) {
        return ChronoUnit.DAYS.between(startDate, endDate);
    }
    
    /**
     * 月の開始日を取得
     * Get first day of month
     */
    public static LocalDate getFirstDayOfMonth(LocalDate date) {
        return date.withDayOfMonth(1);
    }
    
    /**
     * 月の終了日を取得
     * Get last day of month
     */
    public static LocalDate getLastDayOfMonth(LocalDate date) {
        return date.withDayOfMonth(date.lengthOfMonth());
    }
    
    /**
     * 営業日かどうか判定（土日を除く）
     * Check if it's a business day (excluding weekends)
     */
    public static boolean isBusinessDay(LocalDate date) {
        return date.getDayOfWeek().getValue() <= 5; // Monday=1, Sunday=7
    }
}
