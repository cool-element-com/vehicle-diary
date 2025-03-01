package com.cool.element.nav_poc_1

import androidx.lifecycle.ViewModel

interface AppViewModel {

}

interface RecordsListViewModel: AppViewModel {
    /// TODO: INVESTIGATE: could we used a generics here or could we move the types behind an interface?
    fun recordsAsList(): List<DemoRecord>
}

class StubRecordsListViewModel: RecordsListViewModel, ViewModel() {
    override fun recordsAsList(): List<DemoRecord> {
        return DemoRecord.sampleList
    }
}

interface RecordDetailsViewModel: AppViewModel {
    // TODO: INVESTIGATE: potential race condition here (readers and writers problem)
    fun record(): DemoRecord
    fun setRecordId(newValue: Long)
}

class StubRecordDetailsViewModel(
    private var recordId: Long
): RecordDetailsViewModel, ViewModel() {
    override fun record(): DemoRecord {
        val record = DemoRecord.sampleList.find { it.id == recordId }
        return record ?: DemoRecord.unknown
    }

    override fun setRecordId(newValue: Long) {
        recordId = newValue
    }
}