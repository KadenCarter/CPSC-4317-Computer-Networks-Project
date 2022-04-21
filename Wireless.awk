#Alex: found this to be the very basic structure for awk.
{
    event = $1;
    time = $2;
    node_id = $3;
    pkt_size = $8;
    level = $4;

    if (event == "s") {
        sent++;
        if (!startTime || (time < startTime)) {
            startTime = time;
        }
    }

    if (event == "r") {
        receive++;
        if (time > stopTime) {
            stopTime = time;
        }
        recvdSize += pkt_size;
    }
}

END{
    printf("sent_packets\t %d\n",sent);
    printf("received_packets %d\n",receive);
    printf("Average Throughput[bps] = %.2f\tStartTime=%.2f\tStopTime = %.2f\n", ((recvdSize*8)/(stopTime-startTime)),startTime,stopTime);
}