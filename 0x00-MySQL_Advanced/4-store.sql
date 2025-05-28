-- buy buy buy
-- create trigger that decreases the quantity of
-- an item after a table is updated
CREATE TRIGGER items_update AFTER INSERT on orders
    FOR EACH ROW UPDATE items SET quantity = quantity - NEW.number WHERE `name` = NEW.item_name;
