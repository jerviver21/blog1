class ArticlesController < ApplicationController
 #GET /articles
 def index
   @articles = Article.all
   @article
 end
 
 #GET /article/:id
 def show
   @article = Article.find(params[:id])
 end
 
 #GET /articles/new
 def new
   @article = Article.new
 end
 
 #POST /articles
 def create
   #@article = Article.new(title: params[:article][:title], body: params[:article][:body])
   #Mejor usamos Strong params, para que ActiveRecord entienda JSON
   @article = current_user.articles.new(articles_params)
   #Realizamos las validaciones
   if @article.save
    redirect_to @article 
   else
    render :new
   end
   
 end
 
 #PUT /articles/:id
 def destroy
   @article = Article.find(params[:id])
   @article.destroy #Elimina el objeto de la BD
   redirect_to articles_path
 end
 
 #GET /articles/:id/edit
 def edit
   @article = Article.find(params[:id])
 end
 
 #DELETE /articles/:id
 def update
  @article = Article.find(params[:id])
  if @article.update(articles_params)
    redirect_to @article 
  else
    render :edit
  end 
 end
 
 #Implementamos strong params, para que active record entienda json, por seguridad se indica cuales campos son permitidos
 private
 
 def articles_params
   params.require(:article).permit(:title, :body)
 end
 
end
