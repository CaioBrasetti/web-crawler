class BiDailyTaskJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Vou executar meu Job"
    sleep 3
    puts "Finalmente consegui!"
  end
end
