package com.example.lolketing_flutter

import android.appwidget.AppWidgetManager
import android.content.Context;
import android.content.SharedPreferences;
import android.net.Uri;
import android.util.Log
import android.widget.RemoteViews;
import es.antonborri.home_widget.HomeWidgetBackgroundIntent;
import es.antonborri.home_widget.HomeWidgetLaunchIntent;
import es.antonborri.home_widget.HomeWidgetProvider;
import com.example.lolketing_flutter.R;
import com.example.lolketing_flutter.MainActivity;
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.POST
//import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import java.util.concurrent.TimeUnit
import androidx.work.ExistingPeriodicWorkPolicy
import androidx.work.PeriodicWorkRequest

class AppWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        // 1시간마다 반복되는 작업 예약
        val fetchDataWorkRequest: PeriodicWorkRequest =
            PeriodicWorkRequest.Builder(FetchDataWorker::class.java, 1, TimeUnit.HOURS)
                .build()

        WorkManager.getInstance(context).enqueueUniquePeriodicWork(
            "FetchDataWork",
            ExistingPeriodicWorkPolicy.REPLACE,
            fetchDataWorkRequest
        )
//        val workRequest = PeriodicWorkRequestBuilder<FetchDataWorker>(15, TimeUnit.MINUTES)
//            .build()
//
//        WorkManager.getInstance(context).enqueue(workRequest)

//        appWidgetIds.forEach { widgetId ->
//            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {
//                setTextViewText(R.id.txtName, "실행 테스트2")
//                val counter = widgetData.getInt("_counter", 0)
//                val counterText = "$counter"
//                setTextViewText(R.id.txtGrade, counterText)
//
//            }
//            appWidgetManager.updateAppWidget(widgetId, views)
//        }
    }

    override fun onEnabled(context: Context) {
        super.onEnabled(context)

        // 위젯이 처음 생성될 때 호출

        // Worker 스케줄링
//        val workRequest = PeriodicWorkRequestBuilder<FetchDataWorker>(15, TimeUnit.MINUTES)
//            .build()
//
//        WorkManager.getInstance(context).enqueue(workRequest)
    }

}