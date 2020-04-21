create or replace trigger updatePricesOnNewPromotions after insert on promotions
    for each row
    begin
        if (:new.id_category is not null) then
            update products set price = (price - (:new.percent/100) * price) where id_category = :new.id_category;
        else
            update products set price = (price - (:new.percent/100) * price) where id = :new.id_product;
        end if;
    end updatePricesOnNewPromotions;
/

create or replace trigger updatePricesOnPromotionDelete before delete on promotions
    for each row
    begin
--         oldPrice - percent/100 * oldPrice = newPrice;
--         oldPrice*(1 - percent/100) = newPrice;
--         oldPrice = newPrice / (1 - percent/100);
        -- restore the old price
        if (:old.id_category is not null) then
            update products set price = price / (1 - :old.percent/100) where id_category = :old.id_category;
        else
            update products set price = price / (1 - :old.percent/100) where id = :old.id_product;
        end if;
    end updatePricesOnPromotionDelete;
/

create or replace package PromotionsPackage is
    procedure addPromotion(p_id_category in int, p_id_product in int, p_nr_limited_orders in int, p_percentage in int);
    procedure deletePromotion (p_id_promotion in int);
    procedure updatePromotion(p_id_promotion in int, p_nr_limited_orders in int);
    function getCurrentPromotions return varchar2;
    function isPromotionAvailableForProduct(p_id_product in int) return varchar2;
end;
/
create or replace package body PromotionsPackage is
    procedure addPromotion(p_id_category in int, p_id_product in int, p_nr_limited_orders in int, p_percentage in int)
    as
        pragma autonomous_transaction;
        v_nextID promotions.id%type;
    begin
        -- only one has to be null
        if ((p_id_category is null and p_id_product is null) or (p_id_category is not null and p_id_product is not null)) then
            return;
        end if;

        -- get next id
        select max(id) + 1 into v_nextID from promotions;
        if (v_nextID is null) then
            v_nextID := 1;
        end if;

        insert into promotions values (v_nextID, p_id_category, p_id_product, p_nr_limited_orders, p_percentage);
        commit;

        return;
    end addPromotion;

    procedure deletePromotion (p_id_promotion in int) as
        pragma autonomous_transaction;
        begin
            delete from promotions where id = p_id_promotion;
            commit;
        end deletePromotion;

    procedure updatePromotion(p_id_promotion in int, p_nr_limited_orders in int)
    as
        pragma autonomous_transaction;
    begin
        update promotions set NRLIMITEDORDERS = p_nr_limited_orders where id = p_id_promotion;
        commit;
        return;
    end updatePromotion;

    function getCurrentPromotions
    return varchar2 as
        v_return varchar2(32000);
    begin
        v_return := '[';
        for v_promotion in (select * from promotions)
        loop
            v_return := v_return || utl_lms.format_message('{"id": %s,' ||
                                                           '"id_category": %s,' ||
                                                           '"id_product": %s",' ||
                                                           '"nr_limited_orders": %s",' ||
                                                           '"percent": %s}', to_char(v_promotion.id), to_char(v_promotion.id_category), to_char(v_promotion.id_product), to_char(v_promotion.NRLIMITEDORDERS), to_char(v_promotion.percent)) || ', ';
        end loop;

        if (length(v_return) > 1) then
            v_return := substr (v_return, 1, length(v_return) - 1);
        end if;

        v_return := v_return || ']';
        return v_return;
    end getCurrentPromotions;


    function isPromotionAvailableForProduct(p_id_product in int)
    return varchar2 as
        v_exists int;
        v_product_category products.id_category%type;
        begin
            select id_category into v_product_category from products where id = p_id_product;
            select count(*) into v_exists from promotions where id_product = p_id_product or id_category = v_product_category;
            if (v_exists = 0) then
                return '{"success": 1, "is_promotion_available_for_product": 0}';
            else
                return '{"success": 1, "is_promotion_available_for_product": 1}';
            end if;
        end isPromotionAvailableForProduct;
end PromotionsPackage;
/