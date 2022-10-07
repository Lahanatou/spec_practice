require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "validation" do
    it "Si le titre n'a pas été saisi, la validation de la tâche n'est pas valide." do
      task = Task.new(title: nil, description: "test", status: :todo, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Title can't be blank"]
    end

    it "Si aucun statut n'est saisi, la Validation de la tâche n'est pas valide." do
      task = Task.new(title: "test", description: "test", status: nil, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Status can't be blank"]
    end

    it "Les tâches ne sont pas valides si un délai d'achèvement n'a pas été saisi." do
      task = Task.new(title: "JCI", description: "JCI22", status: :done, deadline: nil)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Deadline can't be blank"]
    end

    it "Les tâches ne sont pas valides si la date d'achèvement est une date passée." do
      task = Task.new(title: "JCI", description: "JCI22", status: :done, deadline:  '2022-03-30 20:00:00' )
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Deadline must start from today."]
    end

    it "Si la date limite d'achèvement est la date du jour, la tâche est valide." do
      task = Task.new(title: "Essai", description: "test", status: :todo, deadline: '2022-10-08 20:00:00')
      expect(task).to be_valid
      #expect(task.errors.full_messages).to eq ["Task was successfully created."]
    end
  end
end
