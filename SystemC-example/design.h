//-----------------------------------------------------
// 3-bit Gray counter
//-----------------------------------------------------
#include "systemc.h"

SC_MODULE(gray_counter)
{
    sc_in_clk clock;
    sc_in<bool> reset;
    sc_out<sc_uint<3>> counter_out;

    sc_uint<3> bin_count;

    void gray_process()
    {
        if (reset.read() == 1)
        {
            bin_count = 0;
            counter_out.write(0);
        }
        else
        {
            bin_count = (bin_count + 1) % 8;

            sc_uint<3> gray;
            gray = bin_count ^ (bin_count >> 1);

            counter_out.write(gray);

            cout << "@"
                << sc_time_stamp()
                << " Gray counter = "
                << gray
                << endl;
        }
    }

    SC_CTOR(gray_counter)
    {
        bin_count = 0;

        SC_METHOD(gray_process);
        sensitive << reset;
        sensitive << clock.pos();
    }
};