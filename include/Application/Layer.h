#pragma once
#include <cstdint>

typedef int32_t VkResult;

namespace Graphics
{
    class Layer
    {
        public:
        Layer();
        ~Layer();

        private:

        VkResult r;
    };
}