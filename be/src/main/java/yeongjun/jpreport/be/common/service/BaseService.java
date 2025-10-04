package yeongjun.jpreport.be.common.service;

import yeongjun.jpreport.be.common.domain.entity.BaseEntity;
import java.util.List;

/**
 * 基底サービスクラス
 * Base Service Class
 */
public abstract class BaseService<T extends BaseEntity, ID> {
    
    /**
     * エンティティを作成
     * Create entity
     */
    public abstract T create(T entity);
    
    /**
     * IDでエンティティを取得
     * Find entity by ID
     */
    public abstract T findById(ID id);
    
    /**
     * すべてのエンティティを取得
     * Find all entities
     */
    public abstract List<T> findAll();
    
    /**
     * エンティティを更新
     * Update entity
     */
    public abstract T update(T entity);
    
    /**
     * IDでエンティティを削除
     * Delete entity by ID
     */
    public abstract void deleteById(ID id);
    
    /**
     * 論理削除
     * Soft delete
     */
    public abstract void softDelete(ID id);
}
