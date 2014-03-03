#pragma once

/*!
 * vhdlのentityに当たる。
 */
class Entity {
public:
    virtual ~Entity();
    //! クロック関係ない処理
    virtual void update() = 0;
};
