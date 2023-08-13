-- a trigger to decrease item quantity after adding a new order

DROP TRIGGER IF EXISTS reduce_quantity;
DELIMITER $$

CREATE TRIGGER reduce_quantity
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE items
        SET quantity = quantity - NEW.quantity
        WHERE item_id = NEW.item_id;
END $$

DELIMITER ;
