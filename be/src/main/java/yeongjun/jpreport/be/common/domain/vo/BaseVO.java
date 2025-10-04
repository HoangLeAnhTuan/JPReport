package yeongjun.jpreport.be.common.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;

import java.time.LocalDateTime;

/**
 * View Object基底クラス
 * フロントエンドに返すデータの基底クラス
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public abstract class BaseVO {

    // Getters and Setters
    /**
     * 作成日時
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdAt;
    
    /**
     * 更新日時
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedAt;

}
