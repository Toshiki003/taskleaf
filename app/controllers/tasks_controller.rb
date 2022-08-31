class TasksController < ApplicationController
  def index
    @tasks = Task.all #p110一覧表示アクションでタスクデータを取得する。
    #データベースに保存されている全てのタスクデータを取得するためのallメソッド。このメソッドの戻り値を@taskに代入してビューに伝える。
  end

  def show
    @task = Task.find(params[:id])#p112詳細表示機能の実装　指定されたタスクを詳細表示アクションで取得する
  end

  def new
    @task = Task.new#p102新規登録画面のためのアクション実装する。アクションからビューに受け渡しをしたいデータを、
    #インスタンス変数に入れることが、アクションの基本的な役割の一つになります。
  end

  def edit #p117 編集画面を表示するeditアクション
    @task = Task.find(params[:id])
  end

  def update #p117画面から送られてきたデータを使ってデータベースを更新するupdateアクション
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました"
  end

  def destroy #p122
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。" #tasks_url urlがpathということ（絶対パスか相対パスか）
  end

  
  def create #p106登録アクションを実装する。「登録フォームから送られてきたデータをデータベースに保存して、一覧画面に遷移する」という処理
    @task = Task.new(task_params) #安全化されたtaskパラメータをtask_paramsメソッドで取得して、それを使ってTaskオブジェクトを作成します。
    
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
end
