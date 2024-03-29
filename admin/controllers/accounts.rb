Admin.controllers :accounts do

  get :index do
    @accounts = Account.all
    render 'accounts/index'
  end

  get :new do
    @account = Account.new
    render 'accounts/new'
  end

  post :create do
    @account = Account.new(params[:account])
    if @account.save
      flash[:notice] = 'Account was successfully created.'
      redirect url(:accounts, :edit, :id => @account.id)
    else
      render 'accounts/new'
    end
  end

  get :edit, :with => :id do
    @account = Account.get(params[:id])
    if @account
      render 'accounts/edit'
    else
      halt 404
    end
  end

  put :update, :with => :id do
    @account = Account.get(params[:id])
    if @account
      if @account.update(params[:account])
        flash[:notice] = 'Account was successfully updated.'
        redirect url(:accounts, :edit, :id => @account.id)
      else
        render 'accounts/edit'
      end
    else
      halt 404
    end
  end

  delete :destroy, :with => :id do
    account = Account.get(params[:id])
    if account
      if account != current_account && account.destroy
        flash[:notice] = 'Account was successfully destroyed.'
      else
        flash[:error] = 'Unable to destroy Account!'
      end
      redirect url(:accounts, :index)
    else
      halt 404
    end
  end
end
