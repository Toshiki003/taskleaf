class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = current_user.tasks.order(created_at: :desc)
    #データベースに保存されている全てのタスクデータを取得するためのallメソッド。このメソッドの戻り値を@taskに代入してビューに伝える。
  end

  def show
  end

  def new
    @task = Task.new#p102新規登録画面のためのアクション実装する。アクションからビューに受け渡しをしたいデータを、
    #インスタンス変数に入れることが、アクションの基本的な役割の一つになります。
  end

  def edit 
  end

  def update #p117画面から送られてきたデータを使ってデータベースを更新するupdateアクション
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました"
  end

  def destroy #p122
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。" #tasks_url urlがpathということ（絶対パスか相対パスか）
  end

  
  def create #p106登録アクションを実装する。「登録フォームから送られてきたデータをデータベースに保存して、一覧画面に遷移する」という処理
    @task = current_user.tasks.new(task_params)
    if @task.save
       redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。" #次に、redirect_toメソッドを使って遷移させます。@taskに遷移＝？
    else
      render :new
    end
  end

  private #p106より
#task_paramsメソッドは、フォームからリクエストパラメータとして送られてきた情報が想定通りの形であることをチェックし、
#受け付ける想定であるnameとdescriptionの情報だけを抜き取るという役割をする。
  def task_params
    params.require(:task).permit(:name, :description)
  end #詳しくはセキュリティ強化のChapter6-7 p254.
  
  def set_task #p180共通化したい処理。before_actionメソッドによってフィルタをかけた形。
    @task = current_user.tasks.find(params[:id])
  end

end
