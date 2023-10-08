# Visualizing IT Book Market Data on Amazon Book
## 1.Giới thiệu 
Với sự phát triển không ngừng của công nghệ thông tin, nhu cầu tìm kiếm thông tin và cập nhật kiến thức về lĩnh vực này ngày càng được nhiều người quan tâm.

Trong đồ án này, tôi sẽ trình bày kết quả phân tích và đánh giá thị trường sách trong lĩnh vực công nghệ thông tin trên trang Amazon Book.

Qua đó, với tư cách độc giả, bạn đọc có thể tìm hiểu về xu hướng nghiên cứu và sự quan tâm của công chúng dành cho chuyên ngành cụ thể nào, để có thể cập nhật kiến thức cần thiết, bắt kịp xu thế thị trường. 

Về phần đánh giá nhau cầu của thị trường, mặc dù số lượng bán thông tin quan trọng để đánh giá sức mua của sản phẩm. Tuy nhiên, số lượt bán ra không được công khai trên trang web Amazon và chỉ có thể được truy cập bởi các nhà sản xuất hoặc người bán hàng trên Amazon. Vì vậy, để đánh giá xu hướng đọc sách của người tiêu dùng một cách tương đối, tôi dựa vào các tiêu chí  số lượng đánh giá, điểm đánh giá trung bình thay cho số lượt bán.


## 2. Dataset 
Giới thiệu về bộ dữ liệu: bộ dữ liệu được crawl từ Amazon books gồm các thông tin cho từng quyển sách như sau: asins, parent_category, category, isbn_13, title, author, price, publication_date, publisher, rating, review_count.
-	asins: là viết tắt của "Amazon Standard Identification Number". Nó là một mã số duy nhất gồm 10 ký tự dùng để định danh các sản phẩm được bán trên Amazon. Các sản phẩm trên Amazon sử dụng ASIN để phân biệt với các sản phẩm khác.
-	isbn_13: mã số ISBN 13 của sách
-	title: tiêu đề của sách
-	parent_category: là danh mục cha chứa danh mục con của sách đó.
-	category: danh mục con 
-	author: tên tác giả 
-	price: giá bán 
-	publication_date: ngày xuất bản 
-	publisher: tên nhà xuất bản 
-	rating: điểm đánh giá trung bình (thang điểm 5) 
-	review_count: số lượng người dùng đánh giá 

Lưu ý: Trước khi trực quan hóa, bộ dữ liệu đã được làm sạch, loại bỏ các records có giá trị null. 
## 3. Trực quan hóa bằng Tableau
Xem tại đường dẫn [Tableau Public](https://public.tableau.com/app/profile/hai7497/viz/visualizeAmazonbook/Details)
## 4. Nhận xét
### 4.1 Dashboard tổng quan
Dashboard tổng quan cung cấp cho người dùng một số thông tin cơ bản như: tổng số lượng sách, số tác giả, số nhà xuất bản số lượt reviews, mức giá trung bình, điểm đánh giá trung bình cho tất cả 36 danh mục con. 

![overview](https://github.com/tranthithanhhai/My-portfolio/blob/main/Visualizing%20IT%20Book%20Market%20Data%20on%20Amazon%20Book/image/overview.png)

Các biểu đồ còn lại cung cấp thông tin top các quyển sách, tác giả, nhà xuất bản được đa số độc giả quan tâm dựa trên số lượt reviews. 
Dựa vào biểu đồ donut, ta có thể thấy số lượng sách hiện có trên website nhiều nhất nằm ở danh mục Programming Languages: 1122 đầu sách, chiếm 31.95%; kế đến là danh mục Computer Science: 807 đầu sách, chiếm 22.98%; thấp nhất là danh mục Securiry & Encryption: 294, chỉ chiếm 8.37%.

Những danh mục có đánh giá trung bình tốt và nhiều lượt đánh giá thường có khả năng được ưa chuộng hơn. Thứ tự các danh mục theo số lượt reviews giảm dần như sau: Programming Languages, Computer Science, Web Development & Design, Databases & Big Data, Security & Encryption.

Với các thông tin cơ bản trên, nhóm đưa ra một số chiến lực marketing và tối ưu hàng tồn kho như sau: 

-	Tối ưu hàng tồn kho cho danh mục Security & Encryption: Với tỷ lệ chiếm dưới 10% và số lượt reviews thấp nhất, chúng ta có thể hạn chế số lượng sách trong danh mục này để tránh lãng phí hàng tồn kho và tập trung vào các danh mục khác có tiềm năng lớn hơn.
-	Tập trung vào danh mục Programming Language và Computer Science: Vì chúng chiếm hơn 50% tổng số sách bán trên Amazon và có số lượng reviews cao nhất. Đây là những danh mục được khách hàng quan tâm và có nhu cầu mua nhiều, do đó nên tập trung vào nhập hàng và tiếp thị những sách trong các danh mục này.
-	Tiếp tục đầu tư và tăng cường marketing vào Database & Bigdata và Webdevelopment & Design: Những danh mục này có số lượng sách khá lớn và chiếm tỷ lệ cao trong tổng số sách được bán trên Amazon. Việc đầu tư vào những danh mục này có thể giúp mở rộng thị trường, đáp ứng nhu cầu của khách hàng và tăng doanh số.
-	Hạn chế nhập hàng trong danh mục Security & Encryption: Với số lượng được reviews khá ít so với các danh mục khác do đó nên hạn chế nhập hàng trong danh mục này và tập trung vào những danh mục có tiềm năng  phát triển cao hơn.

### 4.2 Dashboard chi tiết 
Phần dashborad chi tiết được thiết kế để đi sâu tìm hiểu thông tin về các danh mục con, cụ thể nên tập trung vào các nhà xuất bản nào, top các quyển sách nào đang được quan tâm trong danh mục con đó.

Trong Tableau, có 2 khái niệm cơ bản là dimension và measure, trong đó: dimension thường là các biến định tính, kiểu chuỗi, ngày tháng; measure thường là các biến định lượng. Trong phần này, nhóm thiết kế bộ filter để có thể chọn lựa các dimension và measure tương ứng, tùy theo nhu cầu của người dùng để tiết kiệm không gian dashboard.

![detail](https://github.com/tranthithanhhai/My-portfolio/blob/main/Visualizing%20IT%20Book%20Market%20Data%20on%20Amazon%20Book/image/detail.png)

Như đã đề cập ở phần dashboard tổng quan, Programming Language danh mục cần được chú trọng vì nhiều độc giả quan tâm nhất. Cụ thể, trong danh mục Programming Language, Python là ngôn ngữ được quan tâm nhiều nhất khi có 73,483 lượt reviews,  Python Crash Course, 2nd Edition: A Hands-On, Project-Based Introduction to Programming và Hands-On Machine Learning with Scikit-Learn, Keras, and TensorFlow: Concepts, Tools, and Techniques to Build Intelligent Systems là 2 quyển sách được reviews nhiều nhất với rating trung bình là 4.7 và 4.8. Với số lượt reviews và rating khá cao, người bán có thể cân nhắc tăng giá sản phẩm để tăng doanh thu hoặc kết hợp chương trình khuyến mãi bán theo combo với các sản phẩm có cùng doanh mục nhưng lại có lượt reviews thấp để cải thiện doanh số cho các sản phẩm này. 

Ngoài ra, dựa vào top 10 nhà xuất bản có lượt reviews cao nhất, đây có thể là các nhà xuất bản phổ biến, được độc giả tin tưởng, người bán có thể cân nhắc nhập hàng từ các nhà xuất bản này và phân phối chúng một cách rộng rãi. Đồng thời, tập trung vào marketing các sản phẩm của những nhà xuất bản này để thu hút khách hàng và tăng doanh số bán hàng. Cụ thể, trong danh mục Programming Language, danh mục con Python: O'Reilly Media, No Starch Press, Manning, Packt Publishing. 

Đối với các nhà xuất bản có lượt reviews thấp, thường là những nhà xuất bản không được khách hàng quan tâm, người bán có thể hạn chế nhập hàng từ các nhà xuất bản này và tập trung vào những nhà xuất bản khác có lượt reviews cao hơn để tối ưu quy trình nhập hàng. Đồng thời, có thể xem xét các chiến lược giảm giá, khuyến mãi khác nhau để giúp tăng doanh số bán hàng cho các sản phẩm của các nhà xuất bản này. 

Trong danh mục Security & Encryption, danh mục con Cryptography tuy không phải là danh mục có số lượng sách hiện có ít nhất trên hệ thống Amazon, nhưng lại là danh mục có số lượt reviews thấp nhất. Do đó, để tối ưu hàng tồn kho, người bán có thể cân nhắc ngưng nhập các mặt hàng thuộc danh mục này. Để chi tiết hơn, người bán có thể  filter bottom các nhà xuất bản hoặc các tiêu đề sách có lượt reviews thấp nhất. 

Các giải pháp BI đưa ra chỉ mang tính chất tương đối, người bán cần kết hợp các thông tin về lượng hàng tồn kho, doanh số bán sản phẩm, tình hình kinh doanh của doanh nghiệp để có thể đưa ra các giải pháp phù hợp hơn. 







 
