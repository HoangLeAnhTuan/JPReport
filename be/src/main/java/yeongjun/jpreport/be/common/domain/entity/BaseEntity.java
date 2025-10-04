package yeongjun.jpreport.be.common.domain.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

/**
 * BaseEntity
 * EN: Common base class for all entities
 *     Contains shared fields such as creation/update timestamps, user IDs,
 *     logical deletion flag, and version number.
 * JP: 向けの共通基底クラス。
 *     作成日時・更新日時・作成者・更新者・削除フラグ・バージョンなど、
 *     全エンティティで共通する項目を保持します。
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public abstract class BaseEntity {

    /**
     * EN: Timestamp when the record was created.
     * JP: レコードが作成された日時。
     */
    private LocalDateTime createdAt;

    /**
     * EN: Timestamp when the record was last updated.
     * JP: レコードが最後に更新された日時。
     */
    private LocalDateTime updatedAt;

    /**
     * EN: ID of the user who created the record.
     * JP: レコードを作成したユーザーのID。
     */
    private Long createdBy;

    /**
     * EN: ID of the user who last updated the record.
     * JP: レコードを最後に更新したユーザーのID。
     */
    private Long updatedBy;

    /**
     * EN: Logical delete flag (soft delete).
     * JP: 論理削除フラグ（ソフトデリート）。
     */
    private Boolean isDeleted = false;

    /**
     * EN: Version number for optimistic locking (manual handling in MyBatis).
     * JP: 楽観的ロック用のバージョン番号（MyBatisでは手動管理）。
     */
    private Long version = 0L;

    // ----------------------------------------------------------
    // Utility Methods / ユーティリティメソッド
    // ----------------------------------------------------------

    /**
     * EN: Called when the entity is updated.
     * JP: エンティティが更新される際に呼び出されます。
     *
     * @param userId ID of the user performing the update / 更新を実行するユーザーID
     */
    public void onUpdate(Long userId) {
        this.updatedAt = LocalDateTime.now();
        this.updatedBy = userId;
    }

    /**
     * EN: Perform a logical (soft) delete.
     * JP: 論理削除（ソフトデリート）を実行します。
     *
     * @param userId ID of the user performing the delete / 削除を実行するユーザーID
     */
    public void softDelete(Long userId) {
        this.isDeleted = true;
        this.updatedAt = LocalDateTime.now();
        this.updatedBy = userId;
    }
}
