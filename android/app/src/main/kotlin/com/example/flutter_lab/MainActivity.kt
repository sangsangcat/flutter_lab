package com.example.flutter_lab

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StringCodec

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //channel 준비.. flutter 와 동일 이름..
        val channel = BasicMessageChannel<String>(flutterEngine.dartExecutor, "myMessageChannel",
            StringCodec.INSTANCE)
        //flutter 의 메시지 수신..
        channel.setMessageHandler { message, reply ->
            //B/L 실행하고..
            //결과 반환..
            reply.reply("Reply from Android")
            //only test....
            //native -> flutter..
            channel.send("Hello from Android") { reply ->
                Log.d("kkang", "reply : $reply")
            }
        }
    }
}
