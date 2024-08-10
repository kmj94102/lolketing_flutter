package com.example.lolketing_flutter

data class IntIdParam(
    val id: Int
)

data class MyInfo(
    val nickname: String,
    val id: String,
    val mobile: String,
    val address: String,
    val lolketingId: Int,
    val grade: String,
    val point: Int,
    val cash: Int,
    val list: List<Coupon>,
    val totalCoupons: Int,
    val availableCoupons: Int
)

data class Coupon(
    val id: Int,
    val name: String,
    val number: String,
    val isUsed: Boolean,
    val rp: Int,
    val timestamp: String,
)