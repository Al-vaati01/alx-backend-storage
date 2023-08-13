-- a trigger to decrease item quantity after adding a new order

CREATE TRIGGER decrease_item_quantity
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE item_id INT;
    DECLARE quantity_ordered INT;

    SELECT NEW.item_id, NEW.quantity INTO item_id, quantity_ordered;

    UPDATE items
    SET quantity = quantity - quantity_ordered
    WHERE item_id = item_id;
END;
