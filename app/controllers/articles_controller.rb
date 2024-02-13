class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id]) #pramas is the hash of the url which will be passed to the controller,then find the article with the id
  end

  def new
    '''This is the new action, which is responsible for rendering the form to create a new article.'''
    @article = Article.new
  end

  def create
    '''This is the create action, which is responsible for creating a new article.'''
    @article = Article.new(title: "...", body: "...")

    if @article.save
      redirect_to @article #redirect to the show page of the article,@article is the article object, equivalent to article_path(@article)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # The edit action is responsible for rendering the form to edit an existing article.
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    '''This is the destroy action, which is responsible for deleting an article.'''
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
    #root_path is the path to the root of the application, equivalent to "/", in this case, it will redirect to the index page of the articles
  end

  private
  # This is a private method that whitelists the parameters that can be used to create an article.
    def article_params
      params.require(:article).permit(:title, :body)
    end
end

