class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "chats_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak
    # Chatにデータを保存
    Chat.create(
      user_id: current_user.id,
      room_id: params['room_id'],
      message: data['message']
    )

    # 部分テンプレートをWebSocket経由で送り出す。
    #   render_messageで部分テンプレートに文字を埋め込みmessageとして送り出している。
    ActionCable.server.broadcast "chats_channel_#{params['room_id']}", message: render_message(data)
  end

private
  def render_message(data)
    # renderではなくrendererに注意してください
    #   rendererは、コントローラの制約を受けずに任意のビューテンプレートをレンダリングします
    ApplicationController.renderer.render(partial: 'chats/message', locals: { message: data, current_user: current_user })
  end

end
