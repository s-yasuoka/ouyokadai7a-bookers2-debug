import consumer from "./consumer"

// consumer.subscriptions.create("ChatChannel", {

$(document).on('turbolinks:load', function () {

    const chats = $('#chats') // chatsのエレメント

    // ルームIDを#chats内のdata-room-idから取得し、
    // chats_channel.rbでも使えるようにする
    const room = consumer.subscriptions.create(
        {channel: "ChatsChannel", room_id: chats.data('room_id')}, {


  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    chats.append(data['message'])
  },

  speak: function() {
    // return this.perform('speak');
    return this.perform('speak', {message: message})
  }
});

  // 入力フォームの制御
    $(document).ready(function () {
        // 入力エリアのエレメント
        const textElement = $('#message')
        // 入力エリアのEnterKey検出
        textElement.keypress(function (event) {
            if (event.shiftKey && event.keyCode === 13) {
                // speakを呼び出し
                room.speak(textElement.val())
                // 入力エリアを空にする
                textElement.val('')
                // submitイベントの取り消し
                //  改行が含まれてしまうための回避
                event.preventDefault()
            }
        })
    })
})