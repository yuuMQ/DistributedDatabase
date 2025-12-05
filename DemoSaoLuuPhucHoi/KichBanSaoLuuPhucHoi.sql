Kịch bản:

Sao lưu CSDL:
1. CSDL đang dùng (có 1 hàng dữ liệu)
2. Sao luu FULL
3. Dùng tiếp: thêm 1 hàng --> 2 hàng
4. Sao lưu DIFF
5. Dùng tiếp: thêm 1 hàng --> 3 hàng
6. Sao lưu LOG
7. Dùng tiếp: thêm 1 hàng --> 4 hàng
8. Bị hư các data files của CSDL
9. Sao lưu TailLOG (phải viết code vì chức năng này SQL server bị lỗi)

Phục hồi CSDL:
1. Phục hồi từ file sao lưu FULL, dặn chờ NORECOVERY
2. Phục hồi từ file sao lưu DIFF, dặn chờ NORECOVERY
3. Phục hồi từ file sao lưu LOG, dặn chờ NORECOVERY
4. Phục hồi từ file sao lưu TailLog, dặn đã xong RECOVERY: tái tạo CSDL.