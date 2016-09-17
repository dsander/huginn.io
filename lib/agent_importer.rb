class AgentImporter

  def self.run
    Agent.transaction do
      Agent.destroy_all
      data = JSON.parse(`cd ../ && cd huginn && RAILS_ENV=production rails runner #{Rails.root}/lib/extract_huginn_agents_script.rbx`)
      data.each do |d|
        Agent.create!(d)
      end
    end
  end
end
