Admin.controllers :posts do

  get :index do
    @posts = Post.all
    render 'posts/index'
  end

  get :new do
    @post = Post.new
    render 'posts/new'
  end

  post :create do
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect url(:posts, :edit, :id => @post.id)
    else
      render 'posts/new'
    end
  end

  get :edit, :with => :id do
    @post = Post.get(params[:id])
    if @post
      render 'posts/edit'
    else
      halt 404
    end
  end

  put :update, :with => :id do
    @post = Post.get(params[:id])
    if @post
      if @post.update(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        redirect url(:posts, :edit, :id => @post.id)
      else
        render 'posts/edit'
      end
    else
      halt 404
    end
  end

  delete :destroy, :with => :id do
    post = Post.get(params[:id])
    if post
      if post.destroy
        flash[:notice] = 'Post was successfully destroyed.'
      else
        flash[:error] = 'Unable to destroy Post!'
      end
      redirect url(:posts, :index)
    else
      halt 404
    end
  end
end
