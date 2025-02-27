package com.cool.element.nav_poc_1

import java.util.UUID

data class DemoRecord (
    val id: Long = UUID.randomUUID().mostSignificantBits,
    val title: String = "No title",
    val description: String = "No description",
) {
    companion object {
        val sample = DemoRecord(
            id = 1000L,
            title = "Test event",
            description = "Test event description"
        )
        val unknown = DemoRecord(
            id = -1L,
            title = "Unknown event",
            description = "This is an unknown event./nIDK what else to say."
        )
        val sampleList: List<DemoRecord>
            get() {
                val result = mutableListOf<DemoRecord>()
                for (i in 0..100) {
                    val record = DemoRecord(
                        id = i.toLong(),
                        title = "Record $i Title",
                        description = "Record $i Description"
                    )
                    result.add(record)
                }
                return result
            }
    }

}