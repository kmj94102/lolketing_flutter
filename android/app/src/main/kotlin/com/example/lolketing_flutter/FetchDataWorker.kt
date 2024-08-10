package com.example.lolketing_flutter

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.widget.RemoteViews
import androidx.work.CoroutineWorker
import androidx.work.WorkerParameters
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.Response
import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.POST
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale

class FetchDataWorker(
    context: Context,
    params: WorkerParameters
) : CoroutineWorker(context, params) {

    override suspend fun doWork(): Result {
        return withContext(Dispatchers.IO) {
            try {
                fetchDataFromServer()
                Result.success()
            } catch (e: Exception) {
                Result.failure()
            }
        }
    }

    private fun fetchDataFromServer() = kotlin.runCatching {
        val retrofit = Retrofit.Builder()
            .baseUrl("https://port-0-mj-api-e9btb72blgnd5rgr.sel3.cloudtype.app/")
            .client(
                OkHttpClient
                    .Builder()
                    .addInterceptor(
                        HttpLoggingInterceptor().apply {
                            HttpLoggingInterceptor.Level.NONE
                        }
                    )
                    .build()
            )
            .addConverterFactory(GsonConverterFactory.create())
            .build()
        val service = retrofit.create(MainService::class.java)
        val response: Response<MyInfo> = service.fetchMyInfo(IntIdParam(13)).execute()
        if (response.isSuccessful) {
            response.body()?.let {
                updateWidget(it)
            }
        }
        Result.success()
    }

    private fun updateWidget(info: MyInfo) {
        val appWidgetManager = AppWidgetManager.getInstance(applicationContext)
        val remoteViews = RemoteViews(applicationContext.packageName, R.layout.widget_layout)
        val formatter = SimpleDateFormat("yyyyMMdd HH:mm:ss", Locale.getDefault())
        remoteViews.setTextViewText(R.id.txtName, info.nickname)
        remoteViews.setTextViewText(
            R.id.txtGrade,
            "${info.grade}\n${formatter.format(Calendar.getInstance().time)}"
        )

        val widgetComponent = ComponentName(applicationContext, AppWidgetProvider::class.java)
        appWidgetManager.updateAppWidget(widgetComponent, remoteViews)
    }

    interface MainService {
        @POST("/user/select/myInfo")
        fun fetchMyInfo(@Body item: IntIdParam): Call<MyInfo>
    }
}
