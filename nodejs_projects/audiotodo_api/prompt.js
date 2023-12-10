

const promptNestedTodo = {
    "todo_title": "{per_todo_title}",
    "todo_content": "{per_todo_content}",
    "deadline": "{per_todo_deadline}",
    "tags": ['{per_todo_tags}'],
    "deadline_time": "{per_todo_deadline_time}",
    "created_time": "{per_todo_created_time}",
}

const promptV1 = {
    "language": "{meeting_lang_code}",
    //"meet_pure_text": "{meeting_text}",
    "meet_suggested_title": "{meet_suggested_title}",
    "meet_content_summarize": "{meeting_content_summarize}",
    "recognize_person_names": ['{meeting_person_names}'],
    "todos": [
        promptNestedTodo
    ]
}

module.exports = promptV1
