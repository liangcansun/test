#include <iostream>
#include <thread>
#include<chrono>

using namespace std;
void test(){
    std::cout<<"ceshiww"<<std::endl;
    this_thread::sleep_for(chrono::milliseconds(10));
}
int main() {
    std::cout << "Hello, Wssorld2113212说的是34323123sds!" << std::endl;
    thread t1(test);
    t1.join();


    return 0;
}
