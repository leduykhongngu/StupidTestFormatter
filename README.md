# Stupid Test Formatter
Một "tool" nhỏ của mình viết bằng Pascal để đổi định dạng test sang Themis Format.
Hỗ trợ các định dạng: *.exINP, *.exOUT. Với exINP và exOUT là phần mở rộng của input và output. 
Với các định dạng khác, các bạn có thể dùng [Test Formatter của KC97](https://sites.google.com/site/kc97bla/test-formatter)

Code mình có dùng windows API nên chỉ chạy được trên windows.

## Update

Mình vừa cập nhật thêm cho tools để nó bớt "stupid" đi một tẹo, một số tính năng như sau:
### Tự động nhận những file có đuôi phổ biến

Chẳng hạn như 'inp','in','out','ans','ok','output','a'. Với những đuôi khác có thể thêm bằng parameters (xem sau đây)

### Nhận parameters từ command line
**-i x**: thay vì nhập từ console thì sẽ nhập từ file "x" (trong file x cần chứa 2 hàng, hàng đầu là đường dẫn tới thư mục chứa test, hàng thứ 2 là tên bài, xem input.example để hiểu thêm)

**-o x**: thay vì xuất logs ra console thì sẽ xuất ra file "x" 

**-l x**: truyền vào đường dẫn tới thư mục chứa test là "x" (Thay cho nhập console)

**-n x**: truyền vào tên bài là "x" (Thay cho nhập console)

**-exI x**: truyền vào extention của input là "x" (dùng trong trường hợp gặp những đuôi file lạ)

**-exO x**: tương tự như exI nhưng dùng cho output


## Cách dùng tools này

Có 2 các dùng
1. Dùng nhập xuất console như cũ
2. Dùng command line và truyền parameters vào (ví dụ như: StupidTestFormatter.exe -n canoc -l D:\nani -o logs.txt thì chương trình sẽ nhận vào tên bài là "canoc", đường dẫn là "D:\nani", ghi logs ra file "logs.txt")

p/s: Thật ra mình chỉ định dừng ở cách 1, nhưng trong lúc làm vài thứ thì mình cần cách 2 để thuận tiện cho việc viết những tools sau hơn, chẳng hạn như đổi rất nhiều bộ test bằng vài dòng parameters thay vì gõ lại nhiều lần. 


