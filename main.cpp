#include <iostream>
#include <thread>
#include<chrono>

using namespace std;
void test(){
    std::cout<<"ceshiww"<<std::endl;
    this_thread::sleep_for(chrono::milliseconds(10));
}
int main() {
    std::cout << "Hello, Wssorld各二分本地高度2113212说的是34323123sds!12312312313" << std::endl;
    thread t1(test);
    t1.join();


    return 0;
}
