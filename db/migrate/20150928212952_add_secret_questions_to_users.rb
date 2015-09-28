class AddSecretQuestionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :secret_question, :string
    add_column :users, :secret_answer, :string
  end
end
