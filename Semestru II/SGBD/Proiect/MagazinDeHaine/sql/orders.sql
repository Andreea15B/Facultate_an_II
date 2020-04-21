create or replace package OrdersPackage is
    procedure placeOrder (p_id_user in int, p_id_product in int, p_quantity in int);
    procedure cancelOrder (p_id_order in int);
    function getOrders (p_id_user in int) return varchar2;
    function getOrderStatus (p_id_user in int, p_id_order in int) return varchar2;
end;
/

create or replace package body OrdersPackage is

    -- placeOrder(id_product, quantity);
   procedure placeOrder (p_id_user in int, p_id_product in int, p_quantity in int)
    as
        pragma autonomous_transaction;
        v_nextID orders.id%type;
        begin
            -- get next id
            select max(id) + 1 into v_nextID from orders;
            if (v_nextID is null) then
                v_nextID := 1;
            end if;

            insert into orders values (v_nextID, p_id_product, p_id_user, sysdate, p_quantity, 'Order placed');
            commit;
        end placeOrder;

    -- cancelOrder(id_order);
    procedure cancelOrder (p_id_order in int)
    as
        pragma autonomous_transaction;
        begin
            delete from orders where id = p_id_order;
            commit;
        end cancelOrder;

    -- getOrders(id_user);
    function getOrders (p_id_user in int)
    return varchar2 as
        v_return varchar2 (32000);
        begin
            v_return := '[';
            for v_order in (select * from orders where id_user = p_id_user)
            loop
                v_return := v_return || to_char (v_order.id) || ',';
            end loop;

            if (length(v_return) > 1) then
                v_return := substr (v_return, 1, length(v_return) - 1);
            end if;

            v_return := v_return || ']';
            return v_return;
        end getOrders;

    -- getOrderStatus(id_user, id_order);
    function getOrderStatus (p_id_user in int, p_id_order in int)
    return varchar2 as
        v_return varchar2 (32000);
        v_order orders%rowtype;
        begin
            v_return := '{"status": ';
            select * into v_order from orders where id_user = p_id_user and id = p_id_order;

            v_return := v_return || '"' || v_order.ORDER_STATUS_CODE || '"';
            v_return := v_return || '}';
            return v_return;
        end getOrderStatus;
end OrdersPackage;
/