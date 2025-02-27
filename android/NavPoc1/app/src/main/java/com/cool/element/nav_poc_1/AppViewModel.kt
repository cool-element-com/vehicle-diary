package com.cool.element.nav_poc_1

interface AppViewModel {

}

interface RecordsListViewModel: AppViewModel {
    /// TODO: INVESTIGATE: could we used a generics here or could we move the types behind an interface?
    fun recordsAsList(): List<DemoRecord>
}

class StubRecordsListViewModel: RecordsListViewModel {
    override fun recordsAsList(): List<DemoRecord> {
        return DemoRecord.sampleList
    }
}

interface RecordDetailsViewModel: AppViewModel {
    fun record(): DemoRecord
}

class StubRecordDetailsViewModel(
    private val record: DemoRecord
): RecordDetailsViewModel {
    override fun record(): DemoRecord {
        return record
    }
}