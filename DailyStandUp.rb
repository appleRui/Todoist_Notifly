require './Todoist'
require './LineNotifly'
require 'date'

i=0
today_task = ''
tommorrow_task = ''
current_day = Date.today
tasks = Todoist.all_tasks_getter

tasks.each do |task|
    if task["due"] != nil && task["due"]["date"] == current_day.strftime("%F")
        today_task << "・#{task["content"]} \n"
        i += 1
    elsif task["due"] != nil && task["due"]["date"] <= (current_day-1).strftime("%F")
        tommorrow_task << "・#{task["content"]} \n"
    end
end

text = <<"EOS"
\n#{current_day.strftime("%Y年%-m月%-d日")}
# 今日やること(#{i}つ)\u{270F}
#{today_task}
# 残ったタスク\u{1F631}
#{tommorrow_task}
EOS

print text

LineNotifly.send(text)

