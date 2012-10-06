Admin.controllers :categories do

  get :index do
    @categories = Category.all
    render 'categories/index'
  end

  get :new do
    @category = Category.new
    render 'categories/new'
  end

  post :create do
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect url(:categories, :edit, :id => @category.id)
    else
      render 'categories/new'
    end
  end

  get :edit, :with => :id do
    @category = Category.get(params[:id])
    if @category
      render 'categories/edit'
    else
      halt 404
    end
  end

  put :update, :with => :id do
    @category = Category.get(params[:id])
    if @category
      if @category.update(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        redirect url(:categories, :edit, :id => @category.id)
      else
        render 'categories/edit'
      end
    else
      halt 404
    end
  end

  delete :destroy, :with => :id do
    category = Category.get(params[:id])
    if category
      if category.destroy
        flash[:notice] = 'Category was successfully destroyed.'
      else
        flash[:error] = 'Unable to destroy Category!'
      end
      redirect url(:categories, :index)
    else
      halt 404
    end
  end
end
