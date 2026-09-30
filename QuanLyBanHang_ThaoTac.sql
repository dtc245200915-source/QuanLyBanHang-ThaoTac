-- Bài tập: Thao tác với CSDL Quản lý bán hàng
USE QuanLyBanHang;

-- 1. Thêm dữ liệu Customer
INSERT INTO Customer (cID, cName, cAge) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

-- 2. Thêm dữ liệu Order
-- Order là từ khóa, vì vậy dùng dấu ` `
INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

-- 3. Thêm dữ liệu Product
INSERT INTO Product (pID, pName, pPrice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

-- 4. Thêm dữ liệu OrderDetail
INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- 5. Hiển thị oID, oDate, oTotalPrice của tất cả hóa đơn
SELECT oID, oDate, oTotalPrice
FROM `Order`;

-- 6. Danh sách khách hàng đã mua hàng và sản phẩm họ đã mua
SELECT DISTINCT
    C.cID,
    C.cName,
    P.pID,
    P.pName
FROM Customer C
JOIN `Order` O ON C.cID = O.cID
JOIN OrderDetail OD ON O.oID = OD.oID
JOIN Product P ON OD.pID = P.pID
ORDER BY C.cID, P.pID;

-- 7. Tên khách hàng không mua bất kỳ sản phẩm nào
SELECT C.cName
FROM Customer C
LEFT JOIN `Order` O ON C.cID = O.cID
WHERE O.oID IS NULL;

-- 8. Mã hóa đơn, ngày bán và giá tiền của từng hóa đơn
SELECT
    O.oID,
    O.oDate,
    SUM(OD.odQTY * P.pPrice) AS oPrice
FROM `Order` O
JOIN OrderDetail OD ON O.oID = OD.oID
JOIN Product P ON OD.pID = P.pID
GROUP BY O.oID, O.oDate
ORDER BY O.oID;
