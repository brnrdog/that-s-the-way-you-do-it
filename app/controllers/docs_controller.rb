class DocsController < ApplicationController
  before_action :set_doc, only: [:show, :edit, :update, :destroy]

  def index
    @docs = Doc.all
  end

  def show
  end

  def new
    @doc = Doc.new
  end

  def edit
  end

  def create
    @doc = Doc.new(doc_params)

    respond_to do |format|
      if @doc.save
        respond_with_success(format, t('doc_created_success'))
      else
        respond_with_unprocessable_entity(format, :new)
      end
    end
  end

  def update
    respond_to do |format|
      if @doc.update(doc_params)
        respond_with_success(format, t('doc_updated_success'))
      else
        respond_with_unprocessable_entity(format, :edit)
      end
    end
  end

  def destroy
    @doc.destroy
    respond_to do |format|
      format.html { redirect_to docs_url, notice: t('doc_deleted_success') }
      format.json { head :no_content }
    end
  end

  private

    def respond_with_success(format, message)
      format.html { redirect_to @doc, notice: message}
      format.json { render :show, status: :created, location: @doc }
    end

    def respond_with_unprocessable_entity(format, view)
      format.html { render view }
      format.json { render json: @doc.errors, status: :unprocessable_entity }
    end

    def set_doc
      @doc = Doc.find(params[:id])
    end

    def doc_params
      params[:doc].permit(:title, :description, :implementation)
    end
end
