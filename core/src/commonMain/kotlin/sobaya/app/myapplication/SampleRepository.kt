package sobaya.app.myapplication

import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

class SampleRepository {
    suspend fun suspendSample(): String {
        delay(1000)
        return "suspendSample"
    }

    fun flowSample(): Flow<String> = flow {
        (0..Int.MAX_VALUE).forEach {
            emit("flowSample$it")
            delay(1000)
        }
    }
}