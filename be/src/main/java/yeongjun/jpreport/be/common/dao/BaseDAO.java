package yeongjun.jpreport.be.common.dao;

import yeongjun.jpreport.be.common.domain.entity.BaseEntity;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 基底DAO インターフェース
 * Base DAO Interface for MyBatis
 * 
 * @param <T> Entity type extending BaseEntity
 * @param <ID> Primary key type
 */
public interface BaseDAO<T extends BaseEntity, ID> {
    
    /**
     * エンティティを挿入
     * Insert entity
     */
    int insert(T entity);
    
    /**
     * エンティティを更新
     * Update entity
     */
    int update(T entity);
    
    /**
     * IDでエンティティを削除（物理削除）
     * Delete entity by ID (hard delete)
     */
    int deleteById(@Param("id") ID id);
    
    /**
     * IDでエンティティを論理削除
     * Soft delete entity by ID
     */
    int softDeleteById(@Param("id") ID id, @Param("updatedBy") Long updatedBy);
    
    /**
     * IDでエンティティを検索
     * Find entity by ID
     */
    T findById(@Param("id") ID id);
    
    /**
     * すべてのエンティティを検索（削除されていないもの）
     * Find all entities (not deleted)
     */
    List<T> findAll();
    
    /**
     * 条件でエンティティを検索
     * Find entities by condition
     */
    List<T> findByCondition(T condition);
    
    /**
     * エンティティの総数を取得
     * Count total entities
     */
    long count();
    
    /**
     * 条件に一致するエンティティ数を取得
     * Count entities by condition
     */
    long countByCondition(T condition);
    
    /**
     * ページング検索
     * Find with pagination
     */
    List<T> findWithPaging(@Param("offset") int offset, @Param("limit") int limit);
    
    /**
     * 条件付きページング検索
     * Find with condition and pagination
     */
    List<T> findByConditionWithPaging(
        @Param("condition") T condition, 
        @Param("offset") int offset, 
        @Param("limit") int limit
    );
}
