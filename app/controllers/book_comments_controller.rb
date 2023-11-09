class BookCommentsController < ApplicationController
  def create

    @book = Book.find(params[:book_id])#bookモデルを通して持ってきたbook_idと同じ箇所を探して（今回は同じidの数字）紐付けする
    @book_comment = current_user.book_comments.new(book_comment_params)#コメントはどのユーザーがしたか分からないといけないためcurrent_userのデータテーブルbook_commentsにあるbook_idと前述で持ってきたidを紐付けている
    @book_comment.book_id = @book.id
    @book_comment.save
    # pp @book
    # pp @book_comment
    # pp @book_comment.book
    # redirect_to book_path(@book.id)
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.find_by(book_id: @book.id)
    @book_comment　= BookComment.find(params[:id]).destroy
    # redirect_to book_path(@book.id)
  end
  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
